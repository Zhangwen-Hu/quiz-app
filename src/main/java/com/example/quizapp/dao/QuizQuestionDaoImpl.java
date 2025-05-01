package com.example.quizapp.dao;

import com.example.quizapp.entity.QuizQuestion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.List;
import java.util.Objects;

@Repository
public class QuizQuestionDaoImpl implements QuizQuestionDao {

    private final JdbcTemplate jdbcTemplate;
    
    private final RowMapper<QuizQuestion> quizQuestionRowMapper = (rs, rowNum) -> {
        QuizQuestion quizQuestion = new QuizQuestion();
        quizQuestion.setQqId(rs.getInt("qq_id"));
        quizQuestion.setQuizId(rs.getInt("quiz_id"));
        quizQuestion.setQuestionId(rs.getInt("question_id"));
        quizQuestion.setUserChoiceId(rs.getInt("user_choice_id"));
        if (rs.wasNull()) {
            quizQuestion.setUserChoiceId(null);
        }
        return quizQuestion;
    };

    @Autowired
    public QuizQuestionDaoImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public QuizQuestion findById(Integer id) {
        try {
            return jdbcTemplate.queryForObject(
                    "SELECT * FROM quiz_question WHERE qq_id = ?",
                    quizQuestionRowMapper,
                    id
            );
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public List<QuizQuestion> findByQuizId(Integer quizId) {
        return jdbcTemplate.query(
                "SELECT * FROM quiz_question WHERE quiz_id = ?",
                quizQuestionRowMapper,
                quizId
        );
    }

    @Override
    public void save(QuizQuestion quizQuestion) {
        KeyHolder keyHolder = new GeneratedKeyHolder();
        
        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(
                    "INSERT INTO quiz_question (quiz_id, question_id, user_choice_id) VALUES (?, ?, ?)",
                    Statement.RETURN_GENERATED_KEYS
            );
            ps.setInt(1, quizQuestion.getQuizId());
            ps.setInt(2, quizQuestion.getQuestionId());
            if (quizQuestion.getUserChoiceId() != null) {
                ps.setInt(3, quizQuestion.getUserChoiceId());
            } else {
                ps.setNull(3, java.sql.Types.INTEGER);
            }
            return ps;
        }, keyHolder);
        
        quizQuestion.setQqId(Objects.requireNonNull(keyHolder.getKey()).intValue());
    }

    @Override
    public void update(QuizQuestion quizQuestion) {
        jdbcTemplate.update(
                "UPDATE quiz_question SET quiz_id = ?, question_id = ?, user_choice_id = ? WHERE qq_id = ?",
                quizQuestion.getQuizId(),
                quizQuestion.getQuestionId(),
                quizQuestion.getUserChoiceId(),
                quizQuestion.getQqId()
        );
    }

    @Override
    public void updateUserChoice(Integer qqId, Integer userChoiceId) {
        jdbcTemplate.update(
                "UPDATE quiz_question SET user_choice_id = ? WHERE qq_id = ?",
                userChoiceId, qqId
        );
    }
} 
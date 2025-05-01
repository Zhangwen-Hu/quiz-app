package com.example.quizapp.dao;

import com.example.quizapp.entity.Choice;
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
public class ChoiceDaoImpl implements ChoiceDao {

    private final JdbcTemplate jdbcTemplate;
    
    private final RowMapper<Choice> choiceRowMapper = (rs, rowNum) -> {
        Choice choice = new Choice();
        choice.setChoiceId(rs.getInt("choice_id"));
        choice.setQuestionId(rs.getInt("question_id"));
        choice.setDescription(rs.getString("description"));
        choice.setCorrect(rs.getBoolean("is_correct"));
        return choice;
    };

    @Autowired
    public ChoiceDaoImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public Choice findById(Integer id) {
        try {
            return jdbcTemplate.queryForObject(
                    "SELECT * FROM choice WHERE choice_id = ?",
                    choiceRowMapper,
                    id
            );
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public List<Choice> findByQuestionId(Integer questionId) {
        return jdbcTemplate.query(
                "SELECT * FROM choice WHERE question_id = ?",
                choiceRowMapper,
                questionId
        );
    }

    @Override
    public void save(Choice choice) {
        KeyHolder keyHolder = new GeneratedKeyHolder();
        
        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(
                    "INSERT INTO choice (question_id, description, is_correct) VALUES (?, ?, ?)",
                    Statement.RETURN_GENERATED_KEYS
            );
            ps.setInt(1, choice.getQuestionId());
            ps.setString(2, choice.getDescription());
            ps.setBoolean(3, choice.isCorrect());
            return ps;
        }, keyHolder);
        
        choice.setChoiceId(Objects.requireNonNull(keyHolder.getKey()).intValue());
    }

    @Override
    public void update(Choice choice) {
        jdbcTemplate.update(
                "UPDATE choice SET question_id = ?, description = ?, is_correct = ? WHERE choice_id = ?",
                choice.getQuestionId(),
                choice.getDescription(),
                choice.isCorrect(),
                choice.getChoiceId()
        );
    }

    @Override
    public void deleteByQuestionId(Integer questionId) {
        jdbcTemplate.update("DELETE FROM choice WHERE question_id = ?", questionId);
    }
} 
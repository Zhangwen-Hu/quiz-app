package com.example.quizapp.dao;

import com.example.quizapp.entity.Question;
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
public class QuestionDaoImpl implements QuestionDao {

    private final JdbcTemplate jdbcTemplate;
    
    private final RowMapper<Question> questionRowMapper = (rs, rowNum) -> {
        Question question = new Question();
        question.setQuestionId(rs.getInt("question_id"));
        question.setCategoryId(rs.getInt("category_id"));
        question.setDescription(rs.getString("description"));
        question.setActive(rs.getBoolean("is_active"));
        return question;
    };

    @Autowired
    public QuestionDaoImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public Question findById(Integer id) {
        try {
            return jdbcTemplate.queryForObject(
                    "SELECT * FROM question WHERE question_id = ?",
                    questionRowMapper,
                    id
            );
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public List<Question> findAll(int limit, int offset) {
        return jdbcTemplate.query(
                "SELECT * FROM question LIMIT ? OFFSET ?",
                questionRowMapper,
                limit, offset
        );
    }

    @Override
    public List<Question> findByCategoryId(Integer categoryId) {
        return jdbcTemplate.query(
                "SELECT * FROM question WHERE category_id = ?",
                questionRowMapper,
                categoryId
        );
    }

    @Override
    public List<Question> findRandomQuestionsByCategory(Integer categoryId, int count) {
        return jdbcTemplate.query(
                "SELECT * FROM question WHERE category_id = ? AND is_active = true ORDER BY RAND() LIMIT ?",
                questionRowMapper,
                categoryId, count
        );
    }

    @Override
    public Integer getTotalQuestionCount() {
        return jdbcTemplate.queryForObject("SELECT COUNT(*) FROM question", Integer.class);
    }

    @Override
    public void save(Question question) {
        KeyHolder keyHolder = new GeneratedKeyHolder();
        
        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(
                    "INSERT INTO question (category_id, description, is_active) VALUES (?, ?, ?)",
                    Statement.RETURN_GENERATED_KEYS
            );
            ps.setInt(1, question.getCategoryId());
            ps.setString(2, question.getDescription());
            ps.setBoolean(3, question.isActive());
            return ps;
        }, keyHolder);
        
        question.setQuestionId(Objects.requireNonNull(keyHolder.getKey()).intValue());
    }

    @Override
    public void update(Question question) {
        jdbcTemplate.update(
                "UPDATE question SET category_id = ?, description = ?, is_active = ? WHERE question_id = ?",
                question.getCategoryId(),
                question.getDescription(),
                question.isActive(),
                question.getQuestionId()
        );
    }

    @Override
    public boolean updateStatus(Integer questionId, boolean isActive) {
        int affectedRows = jdbcTemplate.update(
                "UPDATE question SET is_active = ? WHERE question_id = ?",
                isActive, questionId
        );
        return affectedRows > 0;
    }
} 
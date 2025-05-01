package com.example.quizapp.dao;

import com.example.quizapp.entity.Quiz;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Repository
public class QuizDaoImpl implements QuizDao {

    private final JdbcTemplate jdbcTemplate;
    
    private final RowMapper<Quiz> quizRowMapper = (rs, rowNum) -> {
        Quiz quiz = new Quiz();
        quiz.setQuizId(rs.getInt("quiz_id"));
        quiz.setUserId(rs.getInt("user_id"));
        quiz.setCategoryId(rs.getInt("category_id"));
        quiz.setName(rs.getString("name"));
        
        Timestamp timeStart = rs.getTimestamp("time_start");
        if (timeStart != null) {
            quiz.setTimeStart(timeStart.toLocalDateTime());
        }
        
        Timestamp timeEnd = rs.getTimestamp("time_end");
        if (timeEnd != null) {
            quiz.setTimeEnd(timeEnd.toLocalDateTime());
            quiz.setFinished(true);
        } else {
            quiz.setFinished(false);
        }
        
        return quiz;
    };

    @Autowired
    public QuizDaoImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public Quiz findById(Integer id) {
        try {
            return jdbcTemplate.queryForObject(
                    "SELECT * FROM quiz WHERE quiz_id = ?",
                    quizRowMapper,
                    id
            );
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public Quiz findActiveQuizByUserId(Integer userId) {
        try {
            return jdbcTemplate.queryForObject(
                    "SELECT * FROM quiz WHERE user_id = ? AND time_end IS NULL",
                    quizRowMapper,
                    userId
            );
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public List<Quiz> findByUserId(Integer userId, int limit) {
        return jdbcTemplate.query(
                "SELECT * FROM quiz WHERE user_id = ? ORDER BY time_start DESC LIMIT ?",
                quizRowMapper,
                userId, limit
        );
    }

    @Override
    public List<Quiz> findAll(int limit, int offset) {
        String sql = "SELECT q.*, u.firstname as user_firstname, u.lastname as user_lastname, " +
                    "c.name as category_name " +
                    "FROM quiz q " +
                    "LEFT JOIN user u ON q.user_id = u.user_id " +
                    "LEFT JOIN category c ON q.category_id = c.category_id " +
                    "ORDER BY q.time_start DESC LIMIT ? OFFSET ?";
        
        List<Quiz> quizzes = jdbcTemplate.query(sql, (rs, rowNum) -> {
            Quiz quiz = new Quiz();
            quiz.setQuizId(rs.getInt("quiz_id"));
            quiz.setUserId(rs.getInt("user_id"));
            quiz.setCategoryId(rs.getInt("category_id"));
            quiz.setName(rs.getString("name"));
            
            Timestamp timeStart = rs.getTimestamp("time_start");
            if (timeStart != null) {
                quiz.setTimeStart(timeStart.toLocalDateTime());
            }
            
            Timestamp timeEnd = rs.getTimestamp("time_end");
            if (timeEnd != null) {
                quiz.setTimeEnd(timeEnd.toLocalDateTime());
                quiz.setFinished(true);
            } else {
                quiz.setFinished(false);
            }
            
            // Get user name
            String firstname = rs.getString("user_firstname");
            String lastname = rs.getString("user_lastname");
            if (firstname != null && lastname != null) {
                quiz.setUserName(firstname + " " + lastname);
            } else {
                quiz.setUserName("Unknown User");
            }
            
            // Get category name
            String categoryName = rs.getString("category_name");
            if (categoryName != null) {
                quiz.setCategoryName(categoryName);
            } else {
                quiz.setCategoryName("Unknown Category");
            }
            
            return quiz;
        }, limit, offset);
        
        return quizzes;
    }

    @Override
    public List<Quiz> findByCriteria(Integer categoryId, Integer userId, int limit, int offset) {
        StringBuilder sql = new StringBuilder(
            "SELECT q.*, u.firstname as user_firstname, u.lastname as user_lastname, " +
            "c.name as category_name " +
            "FROM quiz q " +
            "LEFT JOIN user u ON q.user_id = u.user_id " +
            "LEFT JOIN category c ON q.category_id = c.category_id " +
            "WHERE 1=1");
        
        List<Object> params = new ArrayList<>();
        
        if (categoryId != null) {
            sql.append(" AND q.category_id = ?");
            params.add(categoryId);
        }
        
        if (userId != null) {
            sql.append(" AND q.user_id = ?");
            params.add(userId);
        }
        
        sql.append(" ORDER BY q.time_start DESC LIMIT ? OFFSET ?");
        params.add(limit);
        params.add(offset);
        
        List<Quiz> quizzes = jdbcTemplate.query(sql.toString(), (rs, rowNum) -> {
            Quiz quiz = new Quiz();
            quiz.setQuizId(rs.getInt("quiz_id"));
            quiz.setUserId(rs.getInt("user_id"));
            quiz.setCategoryId(rs.getInt("category_id"));
            quiz.setName(rs.getString("name"));
            
            Timestamp timeStart = rs.getTimestamp("time_start");
            if (timeStart != null) {
                quiz.setTimeStart(timeStart.toLocalDateTime());
            }
            
            Timestamp timeEnd = rs.getTimestamp("time_end");
            if (timeEnd != null) {
                quiz.setTimeEnd(timeEnd.toLocalDateTime());
                quiz.setFinished(true);
            } else {
                quiz.setFinished(false);
            }
            
            // Get user name
            String firstname = rs.getString("user_firstname");
            String lastname = rs.getString("user_lastname");
            if (firstname != null && lastname != null) {
                quiz.setUserName(firstname + " " + lastname);
            } else {
                quiz.setUserName("Unknown User");
            }
            
            // Get category name
            String categoryName = rs.getString("category_name");
            if (categoryName != null) {
                quiz.setCategoryName(categoryName);
            } else {
                quiz.setCategoryName("Unknown Category");
            }
            
            return quiz;
        }, params.toArray());
        
        return quizzes;
    }

    @Override
    public List<Quiz> findByCriteria(Integer categoryId, Integer userId, int limit, int offset, String sortBy, String sortDir) {
        StringBuilder sql = new StringBuilder(
            "SELECT q.*, u.firstname as user_firstname, u.lastname as user_lastname, " +
            "c.name as category_name " +
            "FROM quiz q " +
            "LEFT JOIN user u ON q.user_id = u.user_id " +
            "LEFT JOIN category c ON q.category_id = c.category_id " +
            "WHERE 1=1");
        
        List<Object> params = new ArrayList<>();
        
        if (categoryId != null) {
            sql.append(" AND q.category_id = ?");
            params.add(categoryId);
        }
        
        if (userId != null) {
            sql.append(" AND q.user_id = ?");
            params.add(userId);
        }
        
        // Handle the sorting
        sql.append(" ORDER BY ");
        
        // Map the sortBy parameter to the actual column names
        switch (sortBy) {
            case "category":
                sql.append("c.name ");
                break;
            case "user":
                sql.append("CONCAT(u.firstname, ' ', u.lastname) ");
                break;
            case "time_start":
                sql.append("q.time_start ");
                break;
            case "status":
                sql.append("q.time_end IS NULL ");
                break;
            default:
                sql.append("q.time_start ");
                break;
        }
        
        // Add sort direction
        sql.append(sortDir.equalsIgnoreCase("asc") ? "ASC" : "DESC");
        
        // Add secondary sort to ensure consistent ordering
        if (!sortBy.equals("time_start")) {
            sql.append(", q.time_start DESC");
        }
        
        sql.append(" LIMIT ? OFFSET ?");
        params.add(limit);
        params.add(offset);
        
        List<Quiz> quizzes = jdbcTemplate.query(sql.toString(), (rs, rowNum) -> {
            Quiz quiz = new Quiz();
            quiz.setQuizId(rs.getInt("quiz_id"));
            quiz.setUserId(rs.getInt("user_id"));
            quiz.setCategoryId(rs.getInt("category_id"));
            quiz.setName(rs.getString("name"));
            
            Timestamp timeStart = rs.getTimestamp("time_start");
            if (timeStart != null) {
                quiz.setTimeStart(timeStart.toLocalDateTime());
            }
            
            Timestamp timeEnd = rs.getTimestamp("time_end");
            if (timeEnd != null) {
                quiz.setTimeEnd(timeEnd.toLocalDateTime());
                quiz.setFinished(true);
            } else {
                quiz.setFinished(false);
            }
            
            // Get user name
            String firstname = rs.getString("user_firstname");
            String lastname = rs.getString("user_lastname");
            if (firstname != null && lastname != null) {
                quiz.setUserName(firstname + " " + lastname);
            } else {
                quiz.setUserName("Unknown User");
            }
            
            // Get category name
            String categoryName = rs.getString("category_name");
            if (categoryName != null) {
                quiz.setCategoryName(categoryName);
            } else {
                quiz.setCategoryName("Unknown Category");
            }
            
            return quiz;
        }, params.toArray());
        
        return quizzes;
    }

    @Override
    public Integer count() {
        return jdbcTemplate.queryForObject("SELECT COUNT(*) FROM quiz", Integer.class);
    }

    @Override
    public Integer countByCriteria(Integer categoryId, Integer userId) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM quiz WHERE 1=1");
        List<Object> params = new ArrayList<>();
        
        if (categoryId != null) {
            sql.append(" AND category_id = ?");
            params.add(categoryId);
        }
        
        if (userId != null) {
            sql.append(" AND user_id = ?");
            params.add(userId);
        }
        
        return jdbcTemplate.queryForObject(sql.toString(), Integer.class, params.toArray());
    }

    @Override
    public void save(Quiz quiz) {
        KeyHolder keyHolder = new GeneratedKeyHolder();
        
        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(
                    "INSERT INTO quiz (user_id, category_id, name, time_start, time_end) VALUES (?, ?, ?, ?, ?)",
                    Statement.RETURN_GENERATED_KEYS
            );
            ps.setInt(1, quiz.getUserId());
            ps.setInt(2, quiz.getCategoryId());
            ps.setString(3, quiz.getName());
            ps.setTimestamp(4, quiz.getTimeStart() != null ? Timestamp.valueOf(quiz.getTimeStart()) : null);
            ps.setTimestamp(5, quiz.getTimeEnd() != null ? Timestamp.valueOf(quiz.getTimeEnd()) : null);
            return ps;
        }, keyHolder);
        
        quiz.setQuizId(Objects.requireNonNull(keyHolder.getKey()).intValue());
    }

    @Override
    public void update(Quiz quiz) {
        jdbcTemplate.update(
                "UPDATE quiz SET user_id = ?, category_id = ?, name = ?, time_start = ?, time_end = ? WHERE quiz_id = ?",
                quiz.getUserId(),
                quiz.getCategoryId(),
                quiz.getName(),
                quiz.getTimeStart() != null ? Timestamp.valueOf(quiz.getTimeStart()) : null,
                quiz.getTimeEnd() != null ? Timestamp.valueOf(quiz.getTimeEnd()) : null,
                quiz.getQuizId()
        );
    }
} 
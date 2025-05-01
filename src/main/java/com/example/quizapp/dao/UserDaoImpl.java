package com.example.quizapp.dao;

import com.example.quizapp.entity.User;
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
public class UserDaoImpl implements UserDao {

    private final JdbcTemplate jdbcTemplate;
    
    private final RowMapper<User> userRowMapper = (rs, rowNum) -> {
        User user = new User();
        user.setUserId(rs.getInt("user_id"));
        user.setEmail(rs.getString("email"));
        user.setPassword(rs.getString("password"));
        user.setFirstname(rs.getString("firstname"));
        user.setLastname(rs.getString("lastname"));
        user.setActive(rs.getBoolean("is_active"));
        user.setAdmin(rs.getBoolean("is_admin"));
        return user;
    };

    @Autowired
    public UserDaoImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public User findById(Integer id) {
        try {
            return jdbcTemplate.queryForObject(
                    "SELECT * FROM user WHERE user_id = ?",
                    userRowMapper,
                    id
            );
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public User findByEmail(String email) {
        try {
            return jdbcTemplate.queryForObject(
                    "SELECT * FROM user WHERE email = ?",
                    userRowMapper,
                    email
            );
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public List<User> findAll(int limit, int offset) {
        return jdbcTemplate.query(
                "SELECT * FROM user LIMIT ? OFFSET ?",
                userRowMapper,
                limit, offset
        );
    }

    @Override
    public Integer getTotalUserCount() {
        return jdbcTemplate.queryForObject("SELECT COUNT(*) FROM user", Integer.class);
    }

    @Override
    public void save(User user) {
        KeyHolder keyHolder = new GeneratedKeyHolder();
        
        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(
                    "INSERT INTO user (email, password, firstname, lastname, is_active, is_admin) " +
                            "VALUES (?, ?, ?, ?, ?, ?)",
                    Statement.RETURN_GENERATED_KEYS
            );
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFirstname());
            ps.setString(4, user.getLastname());
            ps.setBoolean(5, user.isActive());
            ps.setBoolean(6, user.isAdmin());
            return ps;
        }, keyHolder);
        
        user.setUserId(Objects.requireNonNull(keyHolder.getKey()).intValue());
    }

    @Override
    public void update(User user) {
        jdbcTemplate.update(
                "UPDATE user SET email = ?, password = ?, firstname = ?, lastname = ?, " +
                        "is_active = ?, is_admin = ? WHERE user_id = ?",
                user.getEmail(),
                user.getPassword(),
                user.getFirstname(),
                user.getLastname(),
                user.isActive(),
                user.isAdmin(),
                user.getUserId()
        );
    }

    @Override
    public boolean updateStatus(Integer userId, boolean isActive) {
        int affectedRows = jdbcTemplate.update(
                "UPDATE user SET is_active = ? WHERE user_id = ?",
                isActive, userId
        );
        return affectedRows > 0;
    }

    @Override
    public Integer count() {
        return jdbcTemplate.queryForObject("SELECT COUNT(*) FROM user", Integer.class);
    }
} 
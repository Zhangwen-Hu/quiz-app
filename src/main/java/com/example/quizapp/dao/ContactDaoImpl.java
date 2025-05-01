package com.example.quizapp.dao;

import com.example.quizapp.entity.Contact;
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
import java.util.List;
import java.util.Objects;

@Repository
public class ContactDaoImpl implements ContactDao {

    private final JdbcTemplate jdbcTemplate;
    
    private final RowMapper<Contact> contactRowMapper = (rs, rowNum) -> {
        Contact contact = new Contact();
        contact.setContactId(rs.getInt("contact_id"));
        contact.setSubject(rs.getString("subject"));
        contact.setMessage(rs.getString("message"));
        contact.setEmail(rs.getString("email"));
        contact.setTime(rs.getTimestamp("time").toLocalDateTime());
        return contact;
    };

    @Autowired
    public ContactDaoImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public Contact findById(Integer id) {
        try {
            return jdbcTemplate.queryForObject(
                    "SELECT * FROM contact WHERE contact_id = ?",
                    contactRowMapper,
                    id
            );
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public List<Contact> findAll(int limit, int offset) {
        return jdbcTemplate.query(
                "SELECT * FROM contact ORDER BY time DESC LIMIT ? OFFSET ?",
                contactRowMapper,
                limit, offset
        );
    }

    @Override
    public Integer count() {
        return jdbcTemplate.queryForObject("SELECT COUNT(*) FROM contact", Integer.class);
    }

    @Override
    public void save(Contact contact) {
        KeyHolder keyHolder = new GeneratedKeyHolder();
        
        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(
                    "INSERT INTO contact (subject, message, email, time) VALUES (?, ?, ?, ?)",
                    Statement.RETURN_GENERATED_KEYS
            );
            ps.setString(1, contact.getSubject());
            ps.setString(2, contact.getMessage());
            ps.setString(3, contact.getEmail());
            ps.setTimestamp(4, Timestamp.valueOf(contact.getTime()));
            return ps;
        }, keyHolder);
        
        contact.setContactId(Objects.requireNonNull(keyHolder.getKey()).intValue());
    }
} 
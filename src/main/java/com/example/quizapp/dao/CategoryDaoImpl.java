package com.example.quizapp.dao;

import com.example.quizapp.entity.Category;
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
public class CategoryDaoImpl implements CategoryDao {

    private final JdbcTemplate jdbcTemplate;
    
    private final RowMapper<Category> categoryRowMapper = (rs, rowNum) -> {
        Category category = new Category();
        category.setCategoryId(rs.getInt("category_id"));
        category.setName(rs.getString("name"));
        return category;
    };

    @Autowired
    public CategoryDaoImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public Category findById(Integer id) {
        try {
            return jdbcTemplate.queryForObject(
                    "SELECT * FROM category WHERE category_id = ?",
                    categoryRowMapper,
                    id
            );
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public List<Category> findAll() {
        return jdbcTemplate.query(
                "SELECT * FROM category",
                categoryRowMapper
        );
    }

    @Override
    public void save(Category category) {
        KeyHolder keyHolder = new GeneratedKeyHolder();
        
        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(
                    "INSERT INTO category (name) VALUES (?)",
                    Statement.RETURN_GENERATED_KEYS
            );
            ps.setString(1, category.getName());
            return ps;
        }, keyHolder);
        
        category.setCategoryId(Objects.requireNonNull(keyHolder.getKey()).intValue());
    }

    @Override
    public void update(Category category) {
        jdbcTemplate.update(
                "UPDATE category SET name = ? WHERE category_id = ?",
                category.getName(),
                category.getCategoryId()
        );
    }

    @Override
    public String findMostPopularCategory() {
        try {
            return jdbcTemplate.queryForObject(
                    "SELECT c.name FROM category c " +
                    "INNER JOIN quiz q ON c.category_id = q.category_id " +
                    "GROUP BY c.category_id ORDER BY COUNT(*) DESC LIMIT 1",
                    String.class
            );
        } catch (EmptyResultDataAccessException e) {
            return "N/A";
        }
    }
} 
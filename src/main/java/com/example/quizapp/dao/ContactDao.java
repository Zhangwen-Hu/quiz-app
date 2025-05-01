package com.example.quizapp.dao;

import com.example.quizapp.entity.Contact;

import java.util.List;

public interface ContactDao {
    Contact findById(Integer id);
    List<Contact> findAll(int limit, int offset);
    Integer count();
    void save(Contact contact);
} 
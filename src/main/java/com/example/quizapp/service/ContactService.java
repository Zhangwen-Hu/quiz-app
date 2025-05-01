package com.example.quizapp.service;

import com.example.quizapp.entity.Contact;

import java.util.List;

public interface ContactService {
    Contact findById(Integer id);
    List<Contact> findAll(int page, int size);
    Integer count();
    void save(Contact contact);
} 
package com.example.quizapp.service;

import com.example.quizapp.dao.ContactDao;
import com.example.quizapp.entity.Contact;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class ContactServiceImpl implements ContactService {
    
    private final ContactDao contactDao;

    @Autowired
    public ContactServiceImpl(ContactDao contactDao) {
        this.contactDao = contactDao;
    }

    @Override
    public Contact findById(Integer id) {
        return contactDao.findById(id);
    }

    @Override
    public List<Contact> findAll(int page, int size) {
        int offset = (page - 1) * size;
        return contactDao.findAll(size, offset);
    }

    @Override
    public Integer count() {
        return contactDao.count();
    }

    @Override
    public void save(Contact contact) {
        // Set current time if not set
        if (contact.getTime() == null) {
            contact.setTime(LocalDateTime.now());
        }
        contactDao.save(contact);
    }
} 
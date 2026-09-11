package com.Backend.music_app.repository;

import com.Backend.music_app.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface UserRepository extends JpaRepository<User, UUID> {
    boolean existsUsersByName(String username);

    Optional<User> findUsersByEmail(String email);

    Optional<User> findUsersByName(String name);

}

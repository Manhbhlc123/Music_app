package com.Backend.music_app.validator;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

import java.time.Instant;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.Objects;

import static java.time.LocalDate.now;

public class DobValidator implements ConstraintValidator<DobConstraint, Integer> {

    private int min;

    @Override
    public void initialize(DobConstraint constraintAnnotation) {
        ConstraintValidator.super.initialize(constraintAnnotation);
        min = constraintAnnotation.min();

    }

    @Override
    public boolean isValid(Integer value, ConstraintValidatorContext context) {
        if(value == null)
        {
            return true;
        }

        long year = LocalDate.now().getYear() - value ;


        return year >= min;
    };
    
}

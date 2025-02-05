package com.rem.springairag.service;

import com.rem.springairag.model.Answer;
import com.rem.springairag.model.Question;

public interface OpenAIService {

    Answer getAnswer(Question question);
}

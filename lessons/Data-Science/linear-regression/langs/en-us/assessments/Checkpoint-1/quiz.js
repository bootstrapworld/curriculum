const quizConfig = {
  "questions": [
    {
      "type": "MultipleChoice",
      "prompt": {
        "prompt": "Choose the statement you most agree with about the scatterplot on the left.\n",
        "image": "scatter-positive.png",
        "distractors": [
          "There appears to be a strong negative correlation.",
          "There appears to be a perfect correlation.",
          "There appears to be a weak negative correlation."
        ]
      },
      "answer": {
        "answer": "There appears to be a positive correlation."
      },
      "context": ""
    },
    {
      "type": "MultipleChoice",
      "prompt": {
        "prompt": "A strong negative correlation would have an r-value that is closest to:\n",
        "distractors": [
          "-0.5",
          "0",
          "0.5",
          "1"
        ],
        "answerIndex": 0
      },
      "answer": {
        "answer": "-1"
      },
      "context": ""
    }
  ]
}
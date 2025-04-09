const quizConfig = {
  "multipart": {
    "q": "Twenty-nine individuals are represented by the points in the chart below.\nThe x-axis indicates the number of years worked for a particular company, and the y-axis represents salary.\n\nThe questions on the next 3 slides will focus on this chart.\n",
    "image": "salary-lr-plot.png"
  },
  "questions": [
    {
      "type": "MultipleChoice",
      "multipart": "q",
      "prompt": {
        "prompt": "Individuals at this company should expect that their salaries will increase about ____ every 2 years.\n",
        "image": "salary-lr-plot.png",
        "distractors": [
          "$20,000",
          "$30,000",
          "$40,000"
        ],
        "answerIndex": 0
      },
      "answer": {
        "answer": "$10,000"
      },
      "context": ""
    },
    {
      "type": "MultipleChoice",
      "multipart": "q",
      "prompt": {
        "prompt": "Use the predictor function to calculate how much money you expect would an employee with 15 years of experience to earn.\n",
        "image": "salary-lr-plot.png",
        "distractors": [
          "$142,000",
          "$194,000",
          "$372,000"
        ],
        "answerIndex": 1
      },
      "answer": {
        "answer": "$167,000"
      },
      "context": ""
    },
    {
      "type": "MultipleChoice",
      "multipart": "q",
      "prompt": {
        "prompt": "Use the predictor function to determine about how much money would you expect an employee with no experience to earn.\n",
        "image": "salary-lr-plot.png",
        "distractors": [
          "$0",
          "$15,000",
          "$20,000"
        ],
        "answerIndex": 3
      },
      "answer": {
        "answer": "$25,000"
      },
      "context": ""
    }
  ]
}
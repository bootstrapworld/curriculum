import TOML from "@iarna/toml";
import { type Quiz, QuizView } from "@bootstrapworld/quiz";
import React from "react";
import ReactDOM from "react-dom/client";

import quizStr from "./quiz.toml?raw";
import "./telemetry";

let App = () => {
  let quiz = TOML.parse(quizStr) as any as Quiz;
  return (
    <div>
      <h1>Example quiz</h1>
      <QuizView name="Bootstrap - Assessment" quiz={quiz} />
    </div>
  );
};

ReactDOM.createRoot(document.getElementById("root")!).render(<App />);

pragma solidity 0.5.0;

contract Trivia {
  struct Answer {
    uint answerIndex;
    address user;
  }

  string public question;
  string[] public possibleAnswers;
  Answer[] public answers;
  uint public correctAnswerIndex;
  bool public done;
  address[] public winners;

  mapping(address => bool) public userAnswered;

  constructor () public {
    question = "what is the capital of california?";
    possibleAnswers =  ["sacramento", "los angeles", "san francisco", "napa valley"];
    done = false;
  }

  function answerQuestion(uint _answerIndex) public {
    require(!userAnswered[msg.sender]);
    userAnswered[msg.sender] = true;
    answers.push(Answer(_answerIndex, msg.sender));
  }

  function finishTrivia (uint _correctAnswerIndex) public {
    require(!done);
    done = true;
    correctAnswerIndex = _correctAnswerIndex;

    for (uint i=0; i< answers.length; i++) {
      if (answers[i].answerIndex == correctAnswerIndex) {
        winners.push(answers[i].user);
      }
    }
  }
}

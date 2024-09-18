// Define various individual assessments here that will be combined by the
// build into a JSON file. Comments are allowed, as this file is not JSON itself.

// Assessments should be named according to the material they assess
// Desmos file titles should end with (Desmos)

const DataScience = { 
  "histograms": {
    "title": "Making and Interpreting Histograms",
    "learningObjectives" : [
      "...key from the learningObjective dictionary"...,
      "...key from the learningObjective dictionary"...,
      "...key from the learningObjective dictionary"...,
      ],
    "urls" : {
      "pyret" : "...some url...",
      "wescheme" : "...some url...",
      "codap" : "...some url...",      
    }
  },
};
 
const Algebra = { 
  "writing-examples": {
    "title": "Writing Examples from Word Problems",
    "learningObjectives" : [
      "...key from the learningObjective dictionary"...,
      "...key from the learningObjective dictionary"...,
      "...key from the learningObjective dictionary"...,
      ]
    "urls" : {
      "pyret" : "...some url...",
      "wescheme" : "...some url...",
      "codap" : "...some url...",      
    }
  },
};

const allAssessments = {
  ...DataScience, 
  ...Algebra
}

////////////////////////////////////////////////////////////////////////////////
//
// Don't edit below this!
//
////////////////////////////////////////////////////////////////////////////////

const fs = require('fs');

const jsFile = process.argv[2];

if (fs.existsSync(jsFile)) {
  fs.unlinkSync(jsFile);
}

const jsonString = JSON.stringify(allAssessments);

fs.writeFileSync(jsFile, 'var assessments = ' + jsonString + ';\n');

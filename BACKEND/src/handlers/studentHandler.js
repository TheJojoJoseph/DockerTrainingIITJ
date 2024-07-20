const studentService = require("../services/studentService");
const { responseParser } = require("../../utils/responseParser");

//Handles request to add a Student
module.exports.addStudent = async (req, res) => {
  let result;
  try {
    let payload = req.body;
    let response = await studentService.addStudent(payload);
    result = responseParser("Successfully added student", false, response);
  } catch (error) {
    result = responseParser("Failed to add student", true, error);
  }
  res.status(result.code).json(result);
};

//Handles request to add a Students
module.exports.listStudents = async (req, res) => {
    let result;
    try {
      let payload = req.body;
      let response = await studentService.listStudents(payload);
      result = responseParser("Successfully fetched students", false, response);
    } catch (error) {
      result = responseParser("Failed to fetch student", true, error);
    }
    res.status(result.code).json(result);
  };

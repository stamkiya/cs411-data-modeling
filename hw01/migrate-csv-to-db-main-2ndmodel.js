var mysql      = require('mysql');
const csv = require('csv-parser');
const fs = require('fs');


const CSV_FILE = "./Assignment1_Dataset.csv";


/*
For mysql >= 8.0

execute these cmd to enable password authentication. https://stackoverflow.com/questions/50093144/mysql-8-0-client-does-not-support-authentication-protocol-requested-by-server

ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'YOUR PASSWORD';
flush privileges;
*/
var conn = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : '',
  database : 'employee_a01_2ndmodel'
});

conn.connect(function(err) {
  if (err) throw err;
  console.log("Connected to mysql!!");
});


let job_titles = new Set();


let rows = [];
let emp_status = {}; // { code: status }
let jobTitles = {}; // { id: { name: job, deptCode: code }} 
let departments = {}; // { code: name }
let marial_status = {}; // { code: name}

fs.createReadStream(CSV_FILE)
  .pipe(csv())
  .on('data', async row => {
    rows.push(row);
    emp_status[row['EmpStatusCode']] = row['EmploymentStatus'];
    jobTitles[row['PositionID']] = { title: row['Position'], deptCode: row['DeptCode'] } ;
    departments[row['DeptCode']] = row['Department'];
    marial_status[row['MaritalStatusCode']] = row['MaritalStatus'];


  })
  .on('end', async () => {

    for (const [code, status] of Object.entries(marial_status)) {
      var query = await conn.query("INSERT INTO MarialStatus SET ? ON DUPLICATE KEY UPDATE `code`=code;", {
        code: code,
        status: status
      });
    }
    
    for (const [code, status] of Object.entries(emp_status)) {
      var query = await conn.query("INSERT INTO EmployeeStatus SET ? ON DUPLICATE KEY UPDATE `code`=code;", {
        code: code,
        status: status
      });
    }

    Object.entries(departments).forEach(async ([code, name]) => {
      var query = await conn.query("INSERT INTO Department SET ? ON DUPLICATE KEY UPDATE `code`=code;", {
        code: code,
        name: name
      });
    })

    Object.entries(jobTitles).forEach(async ([id, job]) => {
      var query = await conn.query("INSERT INTO JobTitle SET ? ON DUPLICATE KEY UPDATE `id`=id;", {
        id: id,
        title: job.title,
        department_code: job.deptCode
      });
    });
    let parseCurrency = (str) => str ? parseFloat((str+"").replace(/[^0-9.-]+/g, "")) : null;
    
    for (let row of rows) {
      await conn.query("INSERT INTO Employee SET ?", {
        id: row['EmpID'],
        name: row['EmpName'],
        is_terminated: row['IsTerminated'] == '1' ? true : false,
        salary: parseCurrency(row['AnnualSalary '] || row['HourlyRate ']),
        manager_id: row['ManagerID'] || null,
        emp_status_code: Number(row['EmpStatusCode']),
        job_title_id: Number(row['PositionID'])
      });

      await conn.query("INSERT INTO PersonalInfo SET ?", {
        emp_id: row['EmpID'],
        sex: row['Sex'],
        DOB: row['DateofBirth'],
        zip_code: row['Zip'],
        marrial_status_code: Number(row['MaritalStatusCode'])
      });

      if ((row['TermReason']+"")) {
        await conn.query("INSERT INTO TermReason SET ?", {
          reason: row['TermReason'],
          emp_id: row['EmpID']
        });
      }
    }

    console.log('CSV file successfully processed');
    conn.end();
  });






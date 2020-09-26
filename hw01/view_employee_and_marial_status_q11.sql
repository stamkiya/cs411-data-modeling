USE employee_model02;

SELECT id as 'Emp Id', name as 'Emp Name', status as 'Marial Status'
	FROM Employee emp
    INNER JOIN PersonalInfo info ON emp.id=info.emp_id
    INNER JOIN MarialStatus mstatus ON info.marrial_status_code=mstatus.code;
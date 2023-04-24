select * from vfin_customeraccounts where CustomerAccountType_TargetProductId =  '15527E33-B0B2-ED11-8A07-5CBA2C266DC5'
and CustomerId = (select id from vfin_customers where Reference2 = '15116')  and CreatedBy = 'VFIN_ETL'

select DisbursedAmount,* from vfin_LoanCases where CustomerId = (select id from vfin_customers where Reference2 = '15116') AND 
LoanProductId = '15527E33-B0B2-ED11-8A07-5CBA2C266DC5' and CreatedBy = 'VFIN_ETL'



update vfin_CustomerAccounts set LoanCaseId = '708AC7C9-F32C-41A8-A3A3-53C984C7D285' where id = '9187E70F-0DC5-ED11-9683-A0D3C19B33E8'   
update vfin_CustomerAccounts set LoanCaseId = 'ACE262DE-BB83-4114-A6D7-8A91BB1F8526' where id = '9887E70F-0DC5-ED11-9683-A0D3C19B33E8' 


select Reference1,* from vfin_customers where Reference2 = '172'







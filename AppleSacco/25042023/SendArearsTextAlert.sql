SELECT FullName,Description,Reference1,Reference2,Reference3,Address_MobileLine,Individual_IdentityCardNumber,LoanRegistration_TermInMonths,
LoanAnnualPercentageRate,LoanRegistration_PaymentFrequencyPerYear,LoanInterest_CalculationMode,LoanCaseNumber,LoanTermInMonths,LoanRegistration_GracePeriod,
LoanBalance * -1 as LoanBalance,LoanDefaultAmount,LoanDefaultTimeline,LoanPrepaidAmount,LoanClassificationDescription,LoanLossProvisionAmount,LoanLossProvisionPercentage,LoanInterestDefaultAmount,
LoanClassificationMode,LoanClassification,LoanAmount*-1 as LoanAmount ,LoanDisbursedDate,CustomerAccountType_TargetProductId,CreatedBy,EmployerId,(select description from vfin_Employers where id = EmployerId) as Employer
 , c.CustomerId as CustomerId, c.Id into #temp
FROM vw_CustomerAccountsLoans AS C 
    CROSS APPLY [dbo].[LoanArrearsPosition](
    c.Id,
    getdate(),
    getdate(),
    1,0
    ) 
	where LoanDefaultAmount <> 0 or LoanInterestDefaultAmount <> 0
	order by LoanClassification

	select FullName,Reference1,Reference2,Address_MobileLine,sum(#temp.LoanDefaultAmount + #temp.LoanInterestDefaultAmount) as TotalArears into #temp1 from #temp
	group by FullName,Reference1,Reference2,Address_MobileLine

	 
	INSERT INTO [dbo].[vfin_TextAlerts]
           ([Id]
           ,[TextMessage_Recipient]
           ,[TextMessage_Body]
           ,[TextMessage_DLRStatus]
           ,[TextMessage_Reference]
           ,[TextMessage_Origin]
           ,[TextMessage_Priority]
           ,[TextMessage_SendRetry]
           ,[TextMessage_SecurityCritical]
           ,[CreatedBy]
           ,[CreatedDate])
 
		select 
		newid()[Id]
           , #temp1.Address_MobileLine [TextMessage_Recipient]
           ,concat('Dear ', #temp1.FullName , ' Please note that your loans have arrears of kshs ', #temp1.TotalArears ,
		   ' kindly clear to avoid Penalities or listing in CRB.Dial *879# To Pay Your Loans.')[TextMessage_Body]
           ,4[TextMessage_DLRStatus]
           ,null[TextMessage_Reference]
           ,1[TextMessage_Origin]
           ,7[TextMessage_Priority]
           ,0[TextMessage_SendRetry]
           ,0[TextMessage_SecurityCritical]
           ,'VFIN_ETL'[CreatedBy]
           ,getdate()[CreatedDate]
		from #temp1

	----	select * from #temp
/*
==============================================================
DDL script: Create Bronze Tables
=============================================================
To also Create or alter load_bronze procedure for data loading

Use exec bronze.load_bronze; to execute the stored procedure
==========================================================
*/

Create or alter procedure bronze.load_bronze AS Begin
	Declare @start_time Datetime, @end_time Datetime, @batch_start_time Datetime, @batch_end_time Datetime;
	Begin try
		Set @batch_start_time = GetDate();
		Print  '=======================================================';
		Print 'Loading the Bronze Layer';
		Print  '=======================================================';

		Print  '--------------------------------------------------------';
		Print 'Loading CRM tables'
		Print  '--------------------------------------------------------';

		Set @start_time = GetDate();

		Print '>>Trauncate Table : bronze.crm_cust_info'
		Truncate Table bronze.crm_cust_info;
	
		Print '>>Insert data into : bronze.crm_cust_info'
		BULK INSERT bronze.crm_cust_info from "C:\Users\ayode\Downloads\cust_info.csv"
		WITH (
			 Firstrow = 2,
			 fieldterminator = ',',
			 tablock
		);
		Set @end_time = GetDate();
		Print '<<Load Duration: '+ CAST(Datediff(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
		print '------------------------'

		-- select * from bronze.crm_cust_info;

		-- select count(*) from bronze.crm_cust_info

		Set @start_time = GetDate();
		Print '>>Trauncate Table : bronze.crm_prd_info'
		Truncate Table bronze.crm_prd_info

		Print '>>Insert data into : bronze.crm_prd_info'
		BULK INSERT bronze.crm_prd_info from "C:\Users\ayode\Downloads\prd_info.csv"
		WITH (
			 Firstrow = 2,
			 fieldterminator = ',',
			 tablock
		);
		Set @end_time = GetDate();
		Print '<<Load Duration: '+ CAST(Datediff(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
		print '------------------------'

		Set @start_time = GetDate();
		Print '>>Trauncate Table : bronze.crm_sales_details'
		Truncate Table bronze.crm_sales_details

		Print '>>Insert data into : bronze.crm_sales_details'
		BULK INSERT bronze.crm_sales_details from "C:\Users\ayode\Downloads\sales_details.csv"
		WITH (
			 Firstrow = 2,
			 fieldterminator = ',',
			 tablock
		);
		Set @end_time = GetDate();
		Print '<<Load Duration: '+ CAST(Datediff(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
		print '------------------------'

		Print  '-------------------------------------------------------';
		Print 'Loading ERP tables'
		Print  '--------------------------------------------------------';

		Set @start_time = GetDate();
		Print '>>Trauncate Table : bronze.erp_cust_az12'
		Truncate Table bronze.erp_cust_az12

		Print '>>Insert data into : bronze.erp_cust_az12'
		BULK INSERT bronze.erp_cust_az12 from "C:\Users\ayode\Downloads\cust_az12.csv"
		WITH (
			 Firstrow = 2,
			 fieldterminator = ',',
			 tablock
		);
		Set @end_time = GetDate();
		Print '<<Load Duration: '+ CAST(Datediff(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
		print '------------------------'
		
		Set @start_time = GetDate();
		Print '>>Trauncate Table : bronze.erp_loc_a101'
		Truncate Table bronze.erp_loc_a101;
	
		Print '>>Insert data into : bronze.erp_loc_a101'
		BULK INSERT bronze.erp_loc_a101 from "C:\Users\ayode\Downloads\loc_a101.csv"
		WITH (
			 Firstrow = 2,
			 fieldterminator = ',',
			 tablock
		);
		Set @end_time = GetDate();
		Print '<<Load Duration: '+ CAST(Datediff(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
		print '------------------------'
		
		Set @start_time = GetDate();
		Print '>>Trauncate Table : bronze.erp_px_cat_g1v2'
		Truncate Table bronze.erp_px_cat_g1v2;
		
		Print '>>Insert data into : bronze.erp_px_cat_g1v2'
		BULK INSERT bronze.erp_px_cat_g1v2 from "C:\Users\ayode\Downloads\px_cat_g1v2.csv"
		WITH (
			 Firstrow = 2,
			 fieldterminator = ',',
			 tablock
		);
		Set @end_time = GetDate();
		Print '<<Load Duration: '+ CAST(Datediff(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
		print '------------------------'

		Set @batch_end_time = GetDate();
		Print '================================================================-';
		Print 'Loading Bronze Layer is Completed';
		Print 'Total Load Duration:' + CAST(Datediff(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + 'Seconds';
		Print '================================================================-';
	End try
	Begin catch
		Print '============================================='
		Print 'Error occur during loading Bronze layer'
		Print 'Error Message' + Error_Message();
		Print 'Error Message' + cast(Error_Number() AS NVARCHAR);
		Print 'Error Message' + cast(Error_State() AS NVARCHAR);
		Print '============================================='
	end catch
end

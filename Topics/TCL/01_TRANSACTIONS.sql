/*
DESCRIPTION:
    This script demonstrates Transaction Control Language (TCL) in SQL Server.
    TCL statements manage database transactions and ensure data integrity.
    Main TCL commands: BEGIN TRANSACTION, COMMIT, ROLLBACK, SAVEPOINT
    
    Transactions ensure ACID properties:
    - Atomicity: All or nothing
    - Consistency: Data remains valid
    - Isolation: Concurrent transactions don't interfere
    - Durability: Committed changes are permanent
*/

----------------- CLEANUP -----------------
DROP TABLE IF EXISTS BankAccounts;
----------------- CLEANUP -----------------

-- Create a sample table for transaction demonstration
CREATE TABLE BankAccounts
(
    account_id INT PRIMARY KEY,
    account_holder VARCHAR(100),
    balance DECIMAL(12, 2)
);

-- Insert initial data
INSERT INTO BankAccounts
    (account_id, account_holder, balance)
VALUES
    (1001, 'Alice Johnson', 5000.00),
    (1002, 'Bob Smith', 3000.00),
    (1003, 'Charlie Brown', 7500.00);

-- =====================================================
-- 1) BASIC TRANSACTION - BEGIN TRANSACTION, COMMIT
-- =====================================================

-- A simple transaction that transfers money
BEGIN TRANSACTION;

-- Subtract from source account
UPDATE BankAccounts
SET balance = balance - 500.00
WHERE account_id = 1001;

-- Add to destination account
UPDATE BankAccounts
SET balance = balance + 500.00
WHERE account_id = 1002;

-- Commit the transaction (save changes)
COMMIT;

-- View the results
SELECT *
FROM BankAccounts;

-- =====================================================
-- 2) TRANSACTION WITH ROLLBACK - Undo changes
-- =====================================================

-- Start a transaction
BEGIN TRANSACTION;

-- Attempt to transfer money
UPDATE BankAccounts
SET balance = balance - 2000.00
WHERE account_id = 1001;

UPDATE BankAccounts
SET balance = balance + 2000.00
WHERE account_id = 1003;

-- Display what would happen
SELECT *
FROM BankAccounts;

-- Undo all changes (rollback)
ROLLBACK;

-- Verify rollback - balance remains unchanged
SELECT *
FROM BankAccounts;

-- =====================================================
-- 3) TRANSACTION WITH SAVEPOINT
-- =====================================================

-- Start a transaction
BEGIN TRANSACTION;

-- First operation
UPDATE BankAccounts
SET balance = balance - 300.00
WHERE account_id = 1001;

-- Create a savepoint
SAVE TRANSACTION Savepoint1;

-- Second operation
UPDATE BankAccounts
SET balance = balance + 300.00
WHERE account_id = 1002;

-- Create another savepoint
SAVE TRANSACTION Savepoint2;

-- Third operation (this will be rolled back to Savepoint2)
UPDATE BankAccounts
SET balance = balance - 500.00
WHERE account_id = 1002;

-- Rollback to Savepoint2 (undoes only the third operation)
ROLLBACK TRANSACTION Savepoint2;

-- Commit the transaction (keeps first and second operations)
COMMIT;

-- View results - only first two operations are saved
SELECT *
FROM BankAccounts;

-- =====================================================
-- 4) NESTED TRANSACTIONS
-- =====================================================

-- Outer transaction
BEGIN TRANSACTION;

UPDATE BankAccounts
SET balance = balance - 100.00
WHERE account_id = 1001;

-- Inner transaction
BEGIN TRANSACTION;

UPDATE BankAccounts
SET balance = balance + 100.00
WHERE account_id = 1002;

-- Commit inner transaction
COMMIT;

-- Commit outer transaction
COMMIT;

SELECT *
FROM BankAccounts;

-- =====================================================
-- 5) ERROR HANDLING WITH TRANSACTIONS (TRY-CATCH)
-- =====================================================

BEGIN TRANSACTION;

BEGIN TRY
    -- Attempt a transfer
    UPDATE BankAccounts
    SET balance = balance - 1500.00
    WHERE account_id = 1001;

    -- Simulate an error condition - check if balance is sufficient
    IF (SELECT balance
FROM BankAccounts
WHERE account_id = 1001) < 0
        BEGIN
            THROW 50001, 'Insufficient funds for this transaction', 1;
        END;

    UPDATE BankAccounts
    SET balance = balance + 1500.00
    WHERE account_id = 1003;

    COMMIT;
END
TRY
BEGIN CATCH
-- If error occurs, rollback the transaction
ROLLBACK;

-- Display error information
SELECT
    ERROR_NUMBER() AS ErrorNumber,
    ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

-- Verify results
SELECT *
FROM BankAccounts;

-- Cleanup
DROP TABLE BankAccounts;

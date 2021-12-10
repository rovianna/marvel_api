CREATE TABLE `dim_user_person`(
    `document_number` INT NOT NULL,
    `credential_id` INT NOT NULL,
    `name` TEXT NOT NULL,
    `company_name` TEXT NOT NULL,
    `age` INT NOT NULL,
    `marital_status` TEXT NOT NULL,
    `mother_name` TEXT NOT NULL,
    `phone` INT NOT NULL,
    `email` INT NOT NULL,
    `monthly_wage` INT NOT NULL,
    `birth_date` DATE NOT NULL,
    `client_type` TEXT NOT NULL,
    `client_type` TEXT NOT NULL
);
ALTER TABLE
    `dim_user_person` ADD PRIMARY KEY `dim_user_person_document_number_primary`(`document_number`);
CREATE TABLE `dim_user_location`(
    `user_location_id` INT NOT NULL,
    `neighborhood` TEXT NOT NULL,
    `city` TEXT NOT NULL,
    `state` TEXT NOT NULL,
    `country` TEXT NOT NULL,
    `latitude` INT NOT NULL,
    `longitude` INT NOT NULL
);
ALTER TABLE
    `dim_user_location` ADD PRIMARY KEY `dim_user_location_user_location_id_primary`(`user_location_id`);
CREATE TABLE `dim_user_finances`(
    `client_id` INT NOT NULL,
    `user_finance_id` INT NOT NULL,
    `is_pix_active` TINYINT(1) NOT NULL,
    `credit_card_approval_rate` INT NOT NULL,
    `credit_card_limit` INT NOT NULL,
    `is_loan_active` TINYINT(1) NOT NULL,
    `current_balance` INT NOT NULL,
    `invoice_expiry_date` DATE NOT NULL
);
ALTER TABLE
    `dim_user_finances` ADD PRIMARY KEY `dim_user_finances_client_id_primary`(`client_id`);
ALTER TABLE
    `dim_user_finances` ADD UNIQUE `dim_user_finances_user_finance_id_unique`(`user_finance_id`);
CREATE TABLE `dim_user_events`(
    `client_id` INT NOT NULL,
    `user_event_id` INT NOT NULL,
    `phone_model` TEXT NOT NULL,
    `os_version` TEXT NOT NULL,
    `last_login_date` DATE NOT NULL,
    `last_transaction_date` DATE NOT NULL,
    `current_carrier` TEXT NOT NULL,
    `app_version` TEXT NOT NULL,
    `closed_account_date` DATE NOT NULL,
    `signup_date` DATE NOT NULL
);
ALTER TABLE
    `dim_user_events` ADD PRIMARY KEY `dim_user_events_client_id_primary`(`client_id`);
CREATE TABLE `dim_user_credentials`(
    `credential_id` INT NOT NULL,
    `email` TEXT NOT NULL,
    `account_number` INT NOT NULL,
    `password` TEXT NOT NULL
);
ALTER TABLE
    `dim_user_credentials` ADD PRIMARY KEY `dim_user_credentials_credential_id_primary`(`credential_id`);
CREATE TABLE `dim_user_transactions`(
    `transaction_id` INT NOT NULL,
    `transaction_type` INT NOT NULL,
    `transaction` TEXT NOT NULL,
    `client_id` INT NOT NULL,
    `transaction_date` INT NOT NULL,
    `transaction_fee` INT NOT NULL,
    `installments` INT NOT NULL
);
ALTER TABLE
    `dim_user_transactions` ADD PRIMARY KEY `dim_user_transactions_transaction_id_primary`(`transaction_id`);
ALTER TABLE
    `dim_user_transactions` ADD UNIQUE `dim_user_transactions_transaction_type_unique`(`transaction_type`);
CREATE TABLE `dim_user_credit_card_aquisition`(
    `client_id` INT NOT NULL,
    `acquisition_id` INT NOT NULL,
    `card_sent_at` DATE NOT NULL,
    `card_received_at` DATE NOT NULL,
    `docs_sent_at` DATE NOT NULL,
    `onboarding_initial_date` DATE NOT NULL,
    `onboarding_final_date` DATE NOT NULL,
    `credit_card_color` TEXT NOT NULL,
    `credit_card_tracking_status` TEXT NOT NULL
);
ALTER TABLE
    `dim_user_credit_card_aquisition` ADD PRIMARY KEY `dim_user_credit_card_aquisition_client_id_primary`(`client_id`);
CREATE TABLE `dim_financial_product`(
    `transaction_type` INT NOT NULL,
    `financial_product` TEXT NOT NULL,
    `status` TEXT NOT NULL,
    `initial_date` DATE NOT NULL
);
ALTER TABLE
    `dim_financial_product` ADD PRIMARY KEY `dim_financial_product_transaction_type_primary`(`transaction_type`);
CREATE TABLE `fact_user_transactions`(
    `client_id` INT NOT NULL,
    `acquisition_id` INT NOT NULL,
    `user_event_id` INT NOT NULL,
    `user_location_id` INT NOT NULL,
    `user_finance_id` INT NOT NULL,
    `document_number` INT NOT NULL,
    `first_debit_card_transaction_date` DATE NULL,
    `first_digital_wallet_transfer_date` DATE NULL,
    `first_credit_card_transaction_date` DATE NULL,
    `first_cash_in_date` DATE NULL,
    `first_cash_out_date` DATE NULL,
    `last_cash_in_date` DATE NULL,
    `last_cash_out` DATE NULL,
    `first_pix_cash_in_date` DATE NULL,
    `last_pix_cash_in_date` DATE NULL,
    `first_pix_cashout_date` DATE NULL,
    `last_pix_cashout_date` DATE NULL,
    `n26_spaces_count` INT NULL
);
ALTER TABLE
    `fact_user_transactions` ADD PRIMARY KEY `fact_user_transactions_client_id_primary`(`client_id`);
ALTER TABLE
    `fact_user_transactions` ADD UNIQUE `fact_user_transactions_acquisition_id_unique`(`acquisition_id`);
ALTER TABLE
    `fact_user_transactions` ADD UNIQUE `fact_user_transactions_user_event_id_unique`(`user_event_id`);
ALTER TABLE
    `fact_user_transactions` ADD UNIQUE `fact_user_transactions_user_location_id_unique`(`user_location_id`);
ALTER TABLE
    `fact_user_transactions` ADD UNIQUE `fact_user_transactions_user_finance_id_unique`(`user_finance_id`);
ALTER TABLE
    `fact_user_transactions` ADD UNIQUE `fact_user_transactions_document_number_unique`(`document_number`);
ALTER TABLE
    `fact_user_transactions` ADD CONSTRAINT `fact_user_transactions_user_location_id_foreign` FOREIGN KEY(`user_location_id`) REFERENCES `dim_user_location`(`user_location_id`);
ALTER TABLE
    `dim_user_person` ADD CONSTRAINT `dim_user_person_credential_id_foreign` FOREIGN KEY(`credential_id`) REFERENCES `dim_user_credentials`(`credential_id`);
ALTER TABLE
    `dim_user_transactions` ADD CONSTRAINT `dim_user_transactions_client_id_foreign` FOREIGN KEY(`client_id`) REFERENCES `fact_user_transactions`(`client_id`);
ALTER TABLE
    `dim_user_transactions` ADD CONSTRAINT `dim_user_transactions_transaction_type_foreign` FOREIGN KEY(`transaction_type`) REFERENCES `dim_financial_product`(`transaction_type`);
ALTER TABLE
    `fact_user_transactions` ADD CONSTRAINT `fact_user_transactions_document_number_foreign` FOREIGN KEY(`document_number`) REFERENCES `dim_user_person`(`document_number`);
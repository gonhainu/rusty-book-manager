INSERT INTO
    roles (name)
VALUES
    ('Admin'),
    ('User')
ON CONFLICT DO NOTHING;

INSERT INTO
    users (name, email, password_hash, role_id)
SELECT
    'Eleazar Fig',
    'eleazar.fig@example.com',
    '$2b$12$vNRNOBfPWN7FobJ0l5TuNuTEJF.R7t/nVO3BkDaW7dxpQMy.j4I36',
    role_id
FROM
    roles
WHERE
    name LIKE 'Admin';
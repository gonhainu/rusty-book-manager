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
    '$2b$12$jcIFFkqTuXdTyYmc99/Ig.x72b48KMwtuH2GhuVb4uH2C4lEiF0rq',
    role_id
FROM
    roles
WHERE
    name LIKE 'Admin';
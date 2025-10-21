-- Tag table (created first since it's referenced by other tables)
CREATE TABLE tag (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    parent_id INTEGER REFERENCES tag(id),
    description TEXT
);

-- Page table for static pages
CREATE TABLE page (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    created DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated DATETIME DEFAULT CURRENT_TIMESTAMP,
    published BOOLEAN DEFAULT FALSE,
    title TEXT NOT NULL,
    slug TEXT NOT NULL UNIQUE,
    description TEXT,
    content TEXT
);

-- Image table
CREATE TABLE image (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    created DATETIME DEFAULT CURRENT_TIMESTAMP,
    title TEXT NOT NULL,
    type TEXT NOT NULL,
    description TEXT,
    url TEXT NOT NULL
);

-- Video table
CREATE TABLE video (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    created DATETIME DEFAULT CURRENT_TIMESTAMP,
    title TEXT NOT NULL,
    description TEXT,
    vid TEXT NOT NULL
);

-- Junction table for page-tag relationships (many-to-many)
CREATE TABLE page_tag (
    page_id INTEGER NOT NULL REFERENCES page(id) ON DELETE CASCADE,
    tag_id INTEGER NOT NULL REFERENCES tag(id) ON DELETE CASCADE,
    PRIMARY KEY (page_id, tag_id)
);

-- Junction table for image-tag relationships (many-to-many)
CREATE TABLE image_tag (
    image_id INTEGER NOT NULL REFERENCES image(id) ON DELETE CASCADE,
    tag_id INTEGER NOT NULL REFERENCES tag(id) ON DELETE CASCADE,
    PRIMARY KEY (image_id, tag_id)
);

-- Junction table for video-tag relationships (many-to-many)
CREATE TABLE video_tag (
    video_id INTEGER NOT NULL REFERENCES video(id) ON DELETE CASCADE,
    tag_id INTEGER NOT NULL REFERENCES tag(id) ON DELETE CASCADE,
    PRIMARY KEY (video_id, tag_id)
);

-- Indexes for better performance
CREATE INDEX idx_page_slug ON page(slug);
CREATE INDEX idx_page_published ON page(published);
CREATE INDEX idx_tag_name ON tag(name);
CREATE INDEX idx_tag_parent ON tag(parent_id);

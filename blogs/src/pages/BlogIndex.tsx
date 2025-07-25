import React from 'react';
import { Link } from 'react-router-dom';

const postFiles = import.meta.glob('../posts/**/*.md', { as: 'raw', eager: true });

type PostMeta = {
  slug: string;
  title: string;
  date: string;
};

const getSlug = (path: string) => path.replace('../posts/', '').replace('.md', '');

const parseMeta = (content: string): { title: string; date: string } => {
  const title = content.match(/title:\s*(.+)/)?.[1] ?? 'Untitled';
  const date = content.match(/date:\s*(.+)/)?.[1] ?? '';
  return { title, date };
};

const BlogIndex: React.FC = () => {
  const posts: PostMeta[] = Object.entries(postFiles).map(([path, content]) => {
    const slug = getSlug(path);
    const meta = parseMeta(content);
    return { slug, ...meta };
  }).sort((a, b) => b.date.localeCompare(a.date));

  return (
    <div>
      <h1>My Blog</h1>
      <ul>
        {posts.map(({ slug, title, date }) => (
          <li key={slug}>
            <Link to={`/post/${slug}`}>{title}</Link> <small>{date}</small>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default BlogIndex;

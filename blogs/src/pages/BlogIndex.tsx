import React from 'react';
import { Link } from 'react-router-dom';

// Load markdown as raw text
const postFiles = import.meta.glob('../posts/*.md', { as: 'raw', eager: true });

type PostMeta = {
  slug: string;
  title: string;
  date: string;
};

const getPostMetadata = (): PostMeta[] => {
  return Object.entries(postFiles).map(([path, content]) => {
    const slug = path.split('/').pop()!.replace('.md', '');
    const match = content.match(/title:\s*(.+)\n.*date:\s*(.+)/i);
    return {
      slug,
      title: match?.[1] ?? slug,
      date: match?.[2] ?? '',
    };
  });
};

const BlogIndex: React.FC = () => {
  const posts = getPostMetadata().sort((a, b) => b.date.localeCompare(a.date));

  return (
    <div>
      <h1>Blog</h1>
      <ul>
        {posts.map(({ slug, title, date }) => (
          <li key={slug}>
            <Link to={`/post/${slug}`}>{title}</Link> <small>({date})</small>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default BlogIndex;

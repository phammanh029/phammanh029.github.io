import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';

import { useParams } from 'react-router-dom';
import ReactMarkdown from 'react-markdown';
import remarkGfm from 'remark-gfm';
import rehypeHighlight from 'rehype-highlight';

const postFiles = import.meta.glob('../posts/**/*.md', { as: 'raw' });

const Post: React.FC = () => {
  const { '*': slug } = useParams(); // wildcard match
  const [content, setContent] = useState<string>('');
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const path = `../posts/${slug}.md`;
    const loader = postFiles[path as keyof typeof postFiles];
    if (loader) {
      (loader as () => Promise<string>)()
        .then(setContent)
        .catch(() => setError('Error loading post.'));
    } else {
      setError('Post not found.');
    }
  }, [slug]);

  return (
    <div className="markdown-body" style={{ padding: '2rem' }}>
      <Link to="/" style={{ display: 'inline-block', marginBottom: '1rem' }}>
        ← Back to Home
      </Link>
      {error ? (
        <p>{error}</p>
      ) : (
        <ReactMarkdown
          children={content}
          remarkPlugins={[remarkGfm]}
          rehypePlugins={[rehypeHighlight]}
        />
      )}
    </div>
  );
};

export default Post;

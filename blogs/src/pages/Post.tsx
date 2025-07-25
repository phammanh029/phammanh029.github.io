import React, { useEffect, useState } from 'react';
import ReactMarkdown from 'react-markdown';
import remarkGfm from 'remark-gfm';
import rehypeHighlight from 'rehype-highlight';
import { useParams } from 'react-router-dom';

type Params = {
  slug?: string;
};

const posts = import.meta.glob('../posts/*.md', { as: 'raw' });

const Post: React.FC = () => {
  const { slug } = useParams<Params>();
  const [content, setContent] = useState<string>('');

  useEffect(() => {
    const path = `../posts/${slug}.md`;
    const loader = posts[path as keyof typeof posts];

    if (loader) {
      (loader as () => Promise<string>)().then(setContent);
    } else {
      setContent('# 404\nPost not found.');
    }
  }, [slug]);

  return (
    <div className="markdown-body">
      <ReactMarkdown
        children={content}
        remarkPlugins={[remarkGfm]}
        rehypePlugins={[rehypeHighlight]}
      />
    </div>
  );
};

export default Post;

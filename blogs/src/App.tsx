import 'github-markdown-css/github-markdown.css';
import 'highlight.js/styles/github.css';

import { BrowserRouter, Routes, Route } from 'react-router-dom';
import BlogIndex from './pages/BlogIndex';
import Post from './pages/Post';

const App: React.FC = () => {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<BlogIndex />} />
        <Route path="/post/:slug" element={<Post />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
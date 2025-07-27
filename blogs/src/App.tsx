import { BrowserRouter, Routes, Route } from 'react-router-dom';
import BlogIndex from './pages/BlogIndex';
import Post from './pages/Post';

const App = () => {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<BlogIndex />} />
        <Route path="/post/*" element={<Post />} />
      </Routes>
    </BrowserRouter>
  );
};

export default App;

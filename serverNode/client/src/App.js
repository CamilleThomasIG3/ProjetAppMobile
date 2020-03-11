import React, {Component} from 'react';
import AppNavbar from './component/AppNavbar';
import RemarkList from './component/RemarkList';
import {Provider} from 'react-redux';
import store from './store';

import 'bootstrap/dist/css/bootstrap.min.css';
import './App.css';

function App() {
  return (
    <Provider store={store}>
    <div className="App">
      <AppNavbar/>
      <RemarkList/>
    </div>
    </Provider>
  );
}

export default App;

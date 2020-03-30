import React, { Fragment, useEffect } from 'react';
//import {Container} from 'reactstrap';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom'

// //Components
import AppNavbar from './component/layout/AppNavbar';
import Landing from './component/layout/Landing';
import Register from './component/auth/Register';
import Login from './component/auth/Login';
import Profile from './component/auth/Profile';
import Alert from './component/layout/Alert';
import Remarks from './component/remarks/Remarks';
import RemarkForm from './component/remarks/RemarkForm';
import Remark from './component/remark/Remark';
import Users from './component/admin/Users';
import MyRemarks from './component/remarks/MyRemarks';
import ReportedRemarks from './component/admin/ReportedRemarks';

//redux
import { Provider } from 'react-redux';
import store from './store';
import { loadUser } from './actions/auth';
import setAuthToken from './utils/setAuthToken'


import 'bootstrap/dist/css/bootstrap.min.css';
import './App.css';


const App = () => {
  useEffect(() => {
    if (localStorage.token) {
      setAuthToken(localStorage.token);
      store.dispatch(loadUser());
    }
  }, []);

  return (
    <Provider store={store}>
      <Router>
        <Fragment>
          <AppNavbar />
          <Route exact path='/' component={Landing} />
          <section className="container">
            <Alert />
            <Switch>
              <Route exact path='/register' component={Register} />
              <Route exact path='/login' component={Login} />
              <Route exact path='/profile' component={Profile} />
              <Route exact path='/users' component={Users} />
              <Route exact path='/remarks' component={Remarks}/>
              <Route exact path='/remarkForm' component={RemarkForm}/>
              <Route exact path='/remarks/:id' component={Remark}/>
              <Route exact path='/remarks' component={Remarks} />
              <Route exact path='/remarkForm' component={RemarkForm} />
              <Route exact path='/remarks/:id' component={Remark} />
              <Route exact path='/my-remarks' component={MyRemarks} />
              <Route exact path='/reported-remarks' component={ReportedRemarks} />
            </Switch>
          </section>
        </Fragment>
      </Router>
    </Provider>
  )
}
export default App;

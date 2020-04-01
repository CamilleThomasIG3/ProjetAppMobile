import React, { Fragment, useEffect } from 'react'
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
import NotFound from './component/layout/NotFound';
import PrivateRoute from './component/routing/PrivateRoute';
import PrivateRouteAdmin from './component/routing/PrivateRouteAdmin';

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
              <PrivateRoute exact path='/profile' component={Profile} />
              <PrivateRouteAdmin path='/users' component={Users} />
              <Route exact path='/remarks' component={Remarks}/>
              <PrivateRoute exact path='/remarkForm' component={RemarkForm}/>
              <Route exact path='/remarks/:id' component={Remark}/>
              <PrivateRoute exact path='/my-remarks' component={MyRemarks} />
              <PrivateRouteAdmin exact path='/reported-remarks' component={ReportedRemarks} />
              <Route component={NotFound}/>
            </Switch>
          </section>
        </Fragment>
      </Router>
    </Provider>
  )
}

export default App
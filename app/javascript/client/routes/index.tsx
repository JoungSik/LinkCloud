import React from 'react';
import { BrowserRouter as Router, Redirect, Route, Switch } from 'react-router-dom';
import routes from './data';
import AuthRoute from './auth_route';
import Login from '../pages/login';
import Header from '../components/header';

const Routers = ({ isLoggedIn }: { isLoggedIn: boolean }) => {
    return (
        <Router>
            <Header />
            <Switch>
                <Route exact path={'/login'} component={Login} />
                {
                    routes.map(route => <AuthRoute key={route.path} isLoggedIn={isLoggedIn} route={route} />)
                }
                <Redirect path="*" to="/" />
            </Switch>
        </Router>
    )
}

export default Routers;
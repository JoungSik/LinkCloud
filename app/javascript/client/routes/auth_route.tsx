import React from 'react';
import { Redirect, Route } from 'react-router-dom';
import { RouteProps } from './data';

export interface AuthRouteProps {
  isLoggedIn: boolean;
  route: RouteProps
}

const AuthRoute = ({ isLoggedIn, route }: AuthRouteProps) =>
  isLoggedIn ?
    <Route exact path={route.path} component={route.component} /> :
    <Redirect to="/login" />

export default AuthRoute;
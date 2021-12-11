import React from 'react';

import Home from '../pages/home';

export interface RouteProps {
  path: string,
  component: React.FC
}

const routes: Array<RouteProps> = [
  {
    path: '/',
    component: Home,
  },
];

export default routes;
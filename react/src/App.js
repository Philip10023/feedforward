import React from 'react';
import { Route, IndexRoute, Router, browserHistory } from 'react-router';



const App = (props) => {
  return (
    <Router history={browserHistory}>
      <Route path='/' >
        <Route path='/feeds/:id' component={button} />
      </Route>
    </Router>
  );
}

export default App;

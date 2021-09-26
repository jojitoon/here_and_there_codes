import React, { Fragment } from 'react';
import { Query } from './Query';
import { Loading, ErrorMessage, EndpointList } from './common';

export const BasicQuery = () => (
  <Fragment>
    <h2>BasicQuery</h2>
    <Query url='https://api.github.com'>
      {({ state: { data, loading, error }, actions }) => {
        if (loading) {
          return <Loading />;
        }

        if (error) {
          return <ErrorMessage error={error} />;
        }

        if (data) {
          return (
            <React.Fragment>
              <button onClick={actions.fetch}>Reload</button>
              <EndpointList endpoints={data} />
            </React.Fragment>
          );
        }

        return null;
      }}
    </Query>
  </Fragment>
);

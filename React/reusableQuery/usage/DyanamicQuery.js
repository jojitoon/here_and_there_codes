import React, { Fragment } from 'react';
import { Query } from './Query';
import { Loading, ErrorMessage, SearchInput } from './common';

export const DynamicUrlQuery = () => (
  <Query
    options={{
      headers: { accept: 'application/json' },
    }}
    disableInitialFetch>
    {({ state: { data, loading, error }, actions }) => {
      const handleSearch = (value) =>
        actions.fetch({
          url:
            'https://api.github.com/search/users?q=' +
            encodeURIComponent(value),
          method: 'GET', // optional
        });

      return (
        <Fragment>
          <h2>DynamicUrlQuery</h2>
          <SearchInput onSearch={handleSearch} />
          {loading && <Loading />}
          {error && <ErrorMessage error={error} />}
          <pre>{JSON.stringify(data, null, 2)}</pre>
        </Fragment>
      );
    }}
  </Query>
);

import PropTypes from 'prop-types';
import { PureComponent } from 'react';

import { FormattedMessage, defineMessages, injectIntl } from 'react-intl';

import { Link } from 'react-router-dom';

import { connect } from 'react-redux';

import { fetchServer } from 'mastodon/actions/server';
import { ServerHeroImage } from 'mastodon/components/server_hero_image';
import { ShortNumber } from 'mastodon/components/short_number';
import { Skeleton } from 'mastodon/components/skeleton';
import Account from 'mastodon/containers/account_container';
import { domain } from 'mastodon/initial_state';

const messages = defineMessages({
  aboutActiveUsers: { id: 'server_banner.about_active_users', defaultMessage: 'People using this server during the last 30 days (Monthly Active Users)' },
});

const mapStateToProps = state => ({
  server: state.getIn(['server', 'server']),
});

class ServerBanner extends PureComponent {

  static propTypes = {
    server: PropTypes.object,
    dispatch: PropTypes.func,
    intl: PropTypes.object,
  };

  componentDidMount () {
    const { dispatch } = this.props;
    dispatch(fetchServer());
  }

  render () {
    const { server, intl } = this.props;
    const isLoading = server.get('isLoading');

    return (
      <div className='server-banner'>
        <p>My vote! </p>
        <p>My voice!</p>
        <div></div>
        <p>Making my vote and my voice count.</p>
        <div></div>
        <p>You can share what you care about and everyone can join in with you.</p>
      </div>
    );
  }

}

export default connect(mapStateToProps)(injectIntl(ServerBanner));

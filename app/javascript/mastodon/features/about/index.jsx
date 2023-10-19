import PropTypes from 'prop-types';
import { PureComponent } from 'react';

import { defineMessages, injectIntl, FormattedMessage } from 'react-intl';

import classNames from 'classnames';
import { Helmet } from 'react-helmet';

import { List as ImmutableList } from 'immutable';
import ImmutablePropTypes from 'react-immutable-proptypes';
import { connect } from 'react-redux';

import { fetchServer, fetchExtendedDescription, fetchDomainBlocks  } from 'mastodon/actions/server';
import Column from 'mastodon/components/column';
import { Icon  }  from 'mastodon/components/icon';
import { ServerHeroImage } from 'mastodon/components/server_hero_image';
import { Skeleton } from 'mastodon/components/skeleton';
import Account from 'mastodon/containers/account_container';
import LinkFooter from 'mastodon/features/ui/components/link_footer';

const messages = defineMessages({
  title: { id: 'column.about', defaultMessage: 'Census Information' },
  rules: { id: 'about.rules', defaultMessage: 'Federal Parliment' },
  blocks: { id: 'about.blocks', defaultMessage: 'State Parliment' },
  silenced: { id: 'about.domain_blocks.silenced.title', defaultMessage: 'Limited' },
  silencedExplanation: { id: 'about.domain_blocks.silenced.explanation', defaultMessage: 'You will generally not see profiles and content from this server, unless you explicitly look it up or opt into it by following.' },
  suspended: { id: 'about.domain_blocks.suspended.title', defaultMessage: 'Suspended' },
  suspendedExplanation: { id: 'about.domain_blocks.suspended.explanation', defaultMessage: 'No data from this server will be processed, stored or exchanged, making any interaction or communication with users from this server impossible.' },
});

const severityMessages = {
  silence: {
    title: messages.silenced,
    explanation: messages.silencedExplanation,
  },

  suspend: {
    title: messages.suspended,
    explanation: messages.suspendedExplanation,
  },
};

const mapStateToProps = state => ({
  server: state.getIn(['server', 'server']),
  extendedDescription: state.getIn(['server', 'extendedDescription']),
  domainBlocks: state.getIn(['server', 'domainBlocks']),
});

class Section extends PureComponent {

  static propTypes = {
    title: PropTypes.string,
    children: PropTypes.node,
    open: PropTypes.bool,
    onOpen: PropTypes.func,
  };

  state = {
    collapsed: !this.props.open,
  };

  handleClick = () => {
    const { onOpen } = this.props;
    const { collapsed } = this.state;

    this.setState({ collapsed: !collapsed }, () => onOpen && onOpen());
  };

  render () {
    const { title, children } = this.props;
    const { collapsed } = this.state;

    return (
      <div className={classNames('about__section', { active: !collapsed })}>
        <div className='about__section__title' role='button' tabIndex={0} onClick={this.handleClick}>
          <Icon id={collapsed ? 'chevron-right' : 'chevron-down'} fixedWidth /> {title}
        </div>

        {!collapsed && (
          <div className='about__section__body'>{children}</div>
        )}
      </div>
    );
  }

}

class About extends PureComponent {

  static propTypes = {
    server: ImmutablePropTypes.map,
    extendedDescription: ImmutablePropTypes.map,
    domainBlocks: ImmutablePropTypes.contains({
      isLoading: PropTypes.bool,
      isAvailable: PropTypes.bool,
      items: ImmutablePropTypes.list,
    }),
    dispatch: PropTypes.func.isRequired,
    intl: PropTypes.object.isRequired,
    multiColumn: PropTypes.bool,
  };

  componentDidMount () {
    const { dispatch } = this.props;
    dispatch(fetchServer());
    dispatch(fetchExtendedDescription());
  }

  handleDomainBlocksOpen = () => {
    const { dispatch } = this.props;
    dispatch(fetchDomainBlocks());
  };

  render () {
    const { multiColumn, intl, server, extendedDescription, domainBlocks } = this.props;
    const isLoading = server.get('isLoading');

    return (
      <Column bindToDocument={!multiColumn} label={intl.formatMessage(messages.title)}>
        <div className='scrollable about'>
          <div className='about__header'>
            <p>Your electorate is: </p>
            <h1 style="color:classic-highlight-color;">Clark</h1>
          </div>


          <Section open title={intl.formatMessage(messages.title)}>
            <p>Population: </p>
            <p>Average Age: </p>
            <p>Population: </p>
            <p>Employment Percent: </p>
            <p>Most Common Occupation: </p>
            <p>Most Common Employment Industry: </p>
            <p>Most Common Education Level: </p>
            <p>Average Family Income: </p>
            <p>Most Common Country of Birth: </p>
            <p>Most Common Parental Country of Birth: </p> 
            <p>Percent English Speaking: </p> 
            <p>Most Common Religion: </p> 
          </Section>

          <Section title='Federal Parliment'>
            <p>Your House of Representatives (lower house) member is: </p>
            <p>Your Senate (upper house) members are: </p> 
          </Section>

          <Section title= 'State Parliment'>
            <p>Your House of Assembly (lower house) members are: </p>
          </Section>

        </div>

        <Helmet>
          <title>{intl.formatMessage(messages.title)}</title>
          <meta name='robots' content='all' />
        </Helmet>
      </Column>
    );
  }

}

export default connect(mapStateToProps)(injectIntl(About));

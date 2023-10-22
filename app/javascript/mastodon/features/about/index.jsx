import { FormattedMessage, defineMessages, injectIntl } from 'react-intl';
import { fetchDomainBlocks, fetchElectorateData, fetchExtendedDescription, fetchServer } from 'mastodon/actions/server';

import Account from 'mastodon/containers/account_container';
import Column from 'mastodon/components/column';
import { Helmet } from 'react-helmet';
import { Icon }  from 'mastodon/components/icon';
import { List as ImmutableList } from 'immutable';
import ImmutablePropTypes from 'react-immutable-proptypes';
import LinkFooter from 'mastodon/features/ui/components/link_footer';
import PropTypes from 'prop-types';
import { PureComponent } from 'react';
import { ServerHeroImage } from 'mastodon/components/server_hero_image';
import { Skeleton } from 'mastodon/components/skeleton';
import classNames from 'classnames';
import { connect } from 'react-redux';

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
  electorateData: state.getIn(['server', 'electorateData']),
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
    electorateData: ImmutablePropTypes.map,
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
    dispatch(fetchElectorateData());
  }

  handleDomainBlocksOpen = () => {
    const { dispatch } = this.props;
    dispatch(fetchDomainBlocks());
  };

  render () {
    const { multiColumn, intl, server, extendedDescription, electorateData, domainBlocks } = this.props;

    let electorateDataJSON = {};
    if(!electorateData.get('isLoading')){
      electorateDataJSON = electorateData.toJS().data;
    }
    return (
      <Column bindToDocument={!multiColumn} label={intl.formatMessage(messages.title)}>
        <div className='scrollable about'>
          <div className='about__header'>
            <p>Your Electorate Is:</p>
            <h1>{ electorateData.get('isLoading')? "": electorateDataJSON.electorate?.name || ""}</h1>
          </div>

          <Section open title={intl.formatMessage(messages.title)}>
            { electorateData.get('isLoading')? (
              <>
                <p></p>
              </>
            ) : (
              <>
              <p>Population: {electorateDataJSON.census?.population}</p>
              <p>Average Age: {electorateDataJSON.census?.average_age}</p>
              <p>Employment Percent: {electorateDataJSON.census?.employment / electorateDataJSON.census?.population * 100}%</p>
              <p>Most Common Employment Industry: {electorateDataJSON.census?.most_common_employment}</p>
              <p>Most Common Occupation: {electorateDataJSON.census?.most_common_occupation}</p>
              <p>Most Common Education Level: {electorateDataJSON.census?.most_common_education}</p>
              <p>Average Family Weekly Income: {electorateDataJSON.census?.total_family_income}</p>
              <p>Average Monthly Mortgage Payment: {electorateDataJSON.census?.mortgage_repayment}</p>
              <p>Average Monthly Rental Cost: {electorateDataJSON.census?.rent_range}</p>
              <p>Most Common Country of Birth: {electorateDataJSON.census?.most_common_birth_country}</p>
              <p>Most Common Parental Country of Birth: {electorateDataJSON.census?.most_common_birth_country_parents}</p>
              <p>Percent English Speaking: {electorateDataJSON.census?.language_proficiency}</p>
              <p>Most Common Religion: {electorateDataJSON.census?.most_common_religion}</p>
              </>
            )}
          </Section>

          <Section title='Federal Parliment'>
            { electorateData.get('isLoading')? (
              <>
                <p></p>
                
              </>
            ) : (
              <>
              <p><strong>Your House of Representatives (lower house) member is:</strong></p>
              <p>{electorateDataJSON.federalHorLeaders?.[0]?.name}</p>
              <p><br></br><strong>Your Senate (upper house) members are: </strong></p> 
              <p>{electorateDataJSON.federalSenLeaders?.[0]?.name}</p>
              </>
            )}
            
          </Section>
            
          <Section title='State Parliment'>
            { electorateData.get('isLoading')? (
              <>
                <p></p>
              </>
            ) : (
              <>
              <p><strong>Your House of Assembly (lower house) member is:</strong></p>
              {electorateDataJSON.stateLeaders?.[0]?.name}
              </>
            )}

          </Section>

          <LinkFooter />

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

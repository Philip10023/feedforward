import React, { Component } from 'react';
import BodyField from '../components/BodyField'
import { Button } from 'react-bootstrap';
import { ButtonToolbar } from 'react-bootstrap';
class FormContainer extends Component {
constructor(props) {
  super(props);
  this.state = {
    errors: {},
    bodyConsumed: ''
  }
    this.handleClearForm = this.handleClearForm.bind(this);
    this.handleFormSubmit = this.handleFormSubmit.bind(this);
    this.handleBodyChange = this.handleBodyChange.bind(this);
  }
  handleClearForm(event) {
    event.preventDefault();
    this.setState({
      errors: {},
      bodyConsumed: ''
    })
  }
  handleFormSubmit(event) {
    event.preventDefault();
     {
      let formPayload = {
        message: this.state.bodyConsumed,
        feed_id: this.props.feedId
      };
      this.props.addNewReview(formPayload);
      this.handleClearForm(event);
    }
  }
  handleBodyChange(event) {
    this.setState({ bodyConsumed: event.target.value })
  }
  render() {
    let errorDiv;
    let errorItems;
    if (Object.keys(this.state.errors).length > 0) {
      errorItems = Object.values(this.state.errors).map(error => {
        return(<li key={error}>{error}</li>)
      })
      errorDiv = <div className="callout alert">{errorItems}</div>
    }
  return (
    <form className="callout" onSubmit={this.handleFormSubmit}>
        {errorDiv}
        <BodyField
          content={this.state.bodyConsumed}
          label='Message'
          name='message'
          handlerFunction={this.handleBodyChange}
        />

        <ButtonToolbar>
          <Button bsStyle="primary" bsSize="large" active type="submit">Submit</Button>
          <Button bsSize="large" active onClick={this.handleClearForm}>Clear</Button>
        </ButtonToolbar>
      </form>
    );
  }
}
export default FormContainer;

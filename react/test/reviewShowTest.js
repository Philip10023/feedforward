import ReviewShow from 'components/ReviewShow';

describe('ReviewShow', () => {
  let text,
      wrapper;

  beforeEach(() => {
    wrapper = mount(
      <ReviewShow
        message="words go here"
        author="bobby"
      />
    );
  });

  it('should render review-message with the value of message', () => {
    expect(wrapper.find('.review-message').text()).toBe('words go here');
  });



});

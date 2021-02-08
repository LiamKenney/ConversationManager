import React from "react";
import "./App.css";
import Conversation from "./components/Conversation";
import convServices from "./services/conversationServices";

class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      input: "",
      conversations: [],
    }
  }

  search = (event) => {
    const { value } = event.target;
    if (value) {
      convServices.searchByTitle(value).then(convos => {
        const elements = this.conversationMapper(convos);
        this.setState({
          search: value,
          conversations: elements
        });
      })
    } else {
      convServices.selectAll().then(convos => {
        this.setState(prevState => ({ conversations: this.conversationMapper(convos) }));
      })
    }
  }

  createConvo = () => {
    const data = {
      title: this.state.input
    }
    convServices.create(data).then(() => {
      const newConvo = this.conversationMapper([data]);
      this.setState(prevState => ({
        conversations: prevState.conversations.concat(newConvo),
        input: "",
      }))
    }).catch(err => console.error(err))
  }

  handleInputChange = (event) => {
    this.setState(prevState => ({
      input: event.target.value
    }))
  }

  conversationMapper(convos) {
    return convos.map(convo => <Conversation key={convo.Id} data={convo} />)
  }

  componentDidMount() {
    convServices.selectAll().then(convos => {
      this.setState(prevState => ({ conversations: this.conversationMapper(convos) }));
    })
  }

  render() {
    return (
      <div className="wrapper">
        <div className="container">
          Search:<input type="text" className="search" onChange={this.search} />
          {this.state.conversations || null}
          <div className="button-container">
            <input className="new-text" value={this.state.input} onChange={this.handleInputChange} />
            <div className="create button" onClick={this.createConvo}>Create</div>
          </div>
        </div>
      </div>
    );
  }
}

export default App;

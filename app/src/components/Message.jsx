import React from "react";
import Thought from "./Thought";
import thoughtServices from "../services/thoughtServices";

class Message extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            open: false,
            input: "",
            thoughts: [],
        }
    }

    createThought = (event) => {
        event.stopPropagation();
        const data = {
            text: this.state.input,
            mid: this.props.data.id
        }
        thoughtServices.create(data).then(() => {
            const newThought = this.thoughtMapper([data]);
            this.setState(prevState => ({
                thoughts: prevState.thoughts.concat(newThought),
                input: "",
            }))
        }).catch(err => console.error(err))
    }

    handleInputChange = (event) => {
        this.setState(prevState => ({
            input: event.target.value
        }))
    }

    toggleOpen = () => {
        this.setState(prevState => ({
            open: !prevState.open
        }))
    }

    thoughtMapper(thoughts) {
        console.log(thoughts);
        return thoughts.map(thought => <Thought key={thought.id} data={thought} />)
    }

    componentDidMount() {
        if (this.props.data.id) {
            thoughtServices.selectByMessageId(this.props.data.id).then(thoughts => {
                console.log("Thoughts:", thoughts);
                this.setState(prevState => ({ thoughts: this.thoughtMapper(thoughts) }));
            })
        }
    }

    render() {
        const { text, dateCreated, dateModified } = this.props.data;
        return (
            <div className="message-wrapper">
                <div className="message">
                    <div className="open button" onClick={this.toggleOpen}>{this.state.open ? "Close" : "Open"}</div>
                    <div className="text">{text}
                        <div className="tag">Message</div>
                    </div>
                    <div className="info">
                        <div className="created">{"Created on " + dateCreated}</div>
                        <div className="modified">{"Last modified on " + dateModified}</div>
                    </div>
                    {this.state.open &&
                        <div className="drawer">
                            {this.state.thoughts || null}
                            <div className="button-container">
                                <input className="new-text" value={this.state.input} onChange={this.handleInputChange} />
                                <div className="create button" onClick={this.createThought}>Create</div>
                            </div>
                        </div>
                    }
                </div>
            </div>
        )
    }
}

export default Message;
import React from "react";
import Message from "./Message";
import messageServices from "../services/messageServices";

class Conversation extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            open: false,
            input: "",
            messages: [],
        }
    }

    createMessage = (event) => {
        event.stopPropagation();
        const data = {
            text: this.state.input,
            cid: this.props.data.id
        }
        messageServices.create(data).then(() => {
            const newMessage = this.messageMapper([data]);
            this.setState(prevState => ({
                messages: prevState.messages.concat(newMessage),
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

    messageMapper(messages) {
        return messages.map(message => <Message key={message.id} data={message} />)
    }

    componentDidMount() {
        if (this.props.data.id) {
            messageServices.selectByConversationId(this.props.data.id).then(messages => {
                this.setState(prevState => ({ messages: this.messageMapper(messages) }));
            })
        }
    }

    render() {
        const { title, dateCreated, dateModified } = this.props.data;
        return (
            <div className="conversation-wrapper">
                <div className="conversation">
                    <div className="open button" onClick={this.toggleOpen}>{this.state.open ? "Close" : "Open"}</div>
                    <div className="title">{title}
                        <div className="tag">Conversation</div>
                    </div>
                    <div className="info">
                        <div className="created">{"Created on " + dateCreated}</div>
                        <div className="modified">{"Last modified on " + dateModified}</div>
                    </div>
                    {this.state.open &&
                        <div className="drawer">
                            {this.state.messages || null}
                            <div className="button-container">
                                <input className="new-text" value={this.state.input} onChange={this.handleInputChange} />
                                <div className="create button" onClick={this.createMessage}>Create</div>
                            </div>
                        </div>
                    }
                </div>
            </div>
        )
    }
}

export default Conversation;
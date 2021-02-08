import React from "react";

const Thought = (props) => {
    const { text, dateCreated, dateModified } = props.data;
    return (
        <div className="thought-wrapper">
            <div className="thought">
                <div className="text">{text}
                    <div className="tag">Thought</div></div>
                <div className="info">
                    <div className="created">{"Created on " + dateCreated}</div>
                    <div className="modified">{"Last modified on " + dateModified}</div>
                </div>
            </div>
        </div>
    )
}

export default Thought;
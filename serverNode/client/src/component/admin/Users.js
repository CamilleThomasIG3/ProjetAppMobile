import React, { Fragment, useEffect, useState } from 'react';
import { connect } from 'react-redux';
import { getUsers, deleteUser } from '../../actions/user';
import Spinner from '../layout/Spinner';
import PropTypes from 'prop-types';
import UserItem from './UserItem';


const Users = ({ getUsers, deleteUser, user: { users, loading } }) => {

    const [filter, handleChangeFilter] = useState('recent');
    useEffect(() => {
        getUsers();
        console.log("ICI!!!!")
    }, [getUsers, filter]);


    return loading ? <Spinner /> : (
        <div>
                <h1>Users</h1>
                <br/>
                <button className="btn" value={'recent'} onClick={e=>handleChangeFilter(e.target.value)}>
                    by register date
                </button>
                <button className="btn" value={'admin'} onClick={e=>handleChangeFilter(e.target.value)} >
                    admins
                </button>
                {filter === 'recent' && 
                <Fragment>
                <div className="posts">
                    {users.map(user => (
                        <UserItem key={user._id} user={user} />))}
                </div>
                </Fragment>}

                {filter === 'admin' && 
                <Fragment>
                <div className="posts">
                    {users.filter(user => user.admin === true).map(user => (
                        <UserItem key={user._id} user={user} />))}
                </div>
                </Fragment>}
                
        </div>
    )

}

Users.propTypes = {
    getUsers: PropTypes.func.isRequired,
    user: PropTypes.object.isRequired
}

const mapStateToProps = (state) => ({
    user: state.user
});

export default connect(
    mapStateToProps,
    { getUsers, deleteUser })
    (Users);

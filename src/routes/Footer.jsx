import React from "react";

import './Footer.css'

const Footer = () => {
    return (
        <footer className="footer bg-dark text-white py-5">
            <div className="container">
                <div className="row gy-4">
                    <div className="col-md-3">
                        <h6 className="footer-title">Pages</h6>
                        {['Home', 'Product', 'Pricing', 'About', 'Contact'].map(link => (
                            <a key={link} href="#" className="d-block text-white-50 mb-1">{link}</a>
                        ))}
                    </div>
                    <div className="col-md-3">
                        <h6 className="footer-title">Tomothy</h6>
                        {['Eleanor Edwards', 'Ted Robertson', 'Annette Russell', 'Jennie McKinney', 'Gloria Richards'].map(name => (
                            <p key={name} className="mb-1 text-white-50">{name}</p>
                        ))}
                    </div>
                    <div className="col-md-3">
                        <h6 className="footer-title">Jane Black</h6>
                        {['Philip Jones', 'Product', 'Colleen Russell', 'Marvin Hawkins', 'Bruce Simmons'].map(name => (
                            <p key={name} className="mb-1 text-white-50">{name}</p>
                        ))}
                    </div>
                    <div className="col-md-3">
                        <h6 className="footer-title">Contact</h6>
                        <p className="text-white-50 mb-1"><img src="https://placehold.co/46x46" alt="" className="me-2" />7480 Mockingbird Hill undefined</p>
                        <p className="text-white-50 mb-1"><img src="https://placehold.co/35x35" alt="" className="me-2" />(239) 555-0108</p>
                        <div className="mt-2 d-flex">
                            <img src="https://placehold.co/24x24" alt="Twitter" className="me-3" />
                            <img src="https://placehold.co/24x24" alt="Facebook" className="me-3" />
                            <img src="https://placehold.co/24x24" alt="LinkedIn" />
                        </div>
                    </div>
                </div>
            </div>
        </footer>
    )
};

export default Footer;

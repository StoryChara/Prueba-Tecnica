import React from "react";

import './Home.css'

const Home = () => {
    return (
        <>
            {/* Hero */}
            <section className="hero text-center text-white">
                <div className="container">
                    <h1>The best products<br />start with Figma</h1>
                    <p>Most calendars are designed for teams. Slate is designed for freelancers</p>
                    <button className="btn btn-primary btn-lg">Try For Free</button>
                </div>
            </section>

            {/* Features */}
            <section className="features py-5">
                <div className="container">
                    <h2 className="text-center mb-4">Features</h2>
                    <p className="text-center text-secondary mb-5">Most calendars are designed for teams. Slate is designed for freelancers</p>
                    <div className="row">
                        {[
                            'OpenType features – Variable fonts',
                            'Design with real data',
                            'Fastest way to take action'
                        ].map((title, idx) => (
                            <div className="col-md-4 text-center mb-4" key={idx}>
                                <img src="https://placehold.co/61x61" alt="Icon" className="feature-icon mb-3" />
                                <h5>{title}</h5>
                                <p className="text-secondary small">
                                    Slate helps you see how many more days you need to work to reach your financial goal.
                                </p>
                            </div>
                        ))}
                    </div>
                </div>
            </section>

            {/* Video */}
            <section className="video py-5 bg-light">
                <div className="container">
                    <div className="position-relative mx-auto video-thumb">
                        <img src="https://placehold.co/1177x658" alt="Video thumbnail" className="img-fluid rounded" />
                        <button className="play-btn btn btn-primary">
                            ▶
                        </button>
                    </div>
                </div>
            </section>

            {/* Contact */}
            <section className="contact py-5">
                <div className="container">
                    <h2 className="text-center mb-3">Contact Us</h2>
                    <p className="text-center text-secondary mb-5">Most calendars are designed for teams. Slate is designed for freelancers</p>
                    <div className="row g-4">
                        
                        {/* Form */}
                        <div className="col-md-5">
                            <div className="p-4 rounded shadow-sm bg-white">
                                <h5 className="mb-3">Contact Us</h5>
                                <form>
                                    <div className="mb-3">
                                        <input type="text" className="form-control" placeholder="Your Name" required />
                                    </div>
                                    <div className="mb-3">
                                        <input type="email" className="form-control" placeholder="Your Email" required />
                                    </div>
                                    <div className="mb-3">
                                        <textarea className="form-control" rows="5" placeholder="Your Message" required></textarea>
                                    </div>
                                    <button type="submit" className="btn btn-primary">Send</button>
                                </form>
                            </div>
                        </div>

                        {/* Map & Info */}
                        <div className="col-md-7">
                            <div className="row mb-4">
                                <div className="col-6 text-center">
                                    <div className="contact-icon-box">
                                        <img src="https://placehold.co/26x32" alt="Location" className="contact-icon" />
                                        <p className="contact-text">6386 Spring St undefined Anchorage, Georgia 12473 United States</p>
                                    </div>
                                </div>
                                <div className="col-3 text-center">
                                    <div className="contact-icon-box">
                                        <img src="https://placehold.co/21x34" alt="Phone" className="contact-icon" />
                                        <p className="contact-text">(843) 555-0130</p>
                                    </div>
                                </div>
                                <div className="col-3 text-center">
                                    <div className="contact-icon-box">
                                        <img src="https://placehold.co/27x22" alt="Email" className="contact-icon" />
                                        <p className="contact-text">willie.jennings@example.com</p>
                                    </div>
                                </div>
                            </div>

                            {/* Mapa */}
                            <img src="https://placehold.co/600x350" alt="Map" className="img-fluid rounded" />

                            {/* Social Icons */}
                            <div className="mt-3 d-flex justify-content-center">
                                <img src="https://placehold.co/24x24" alt="Twitter" className="me-3" />
                                <img src="https://placehold.co/24x24" alt="Facebook" className="me-3" />
                                <img src="https://placehold.co/24x24" alt="LinkedIn" />
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </>
    )
};

export default Home;
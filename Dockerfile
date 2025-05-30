# PDF Reader MCP Server Dockerfile
# Author: Philip Van de Walker
# Email: philip.vandewalker@gmail.com
# Repo: https://github.com/trafflux/pdf-reader-mcp
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Use Python 3.11 slim image as base
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install git for MCP SDK installation
RUN apt-get update && \
    apt-get install -y git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install project Python dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy source code into container
COPY src/ .

# Command to run the server
# The container expects a volume mount at /pdfs for accessing local PDF files
ENTRYPOINT ["python", "server.py"]
